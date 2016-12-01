package j_account

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"time"

	"golang.org/x/net/context"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	cr "github.com/go-openapi/runtime/client"

	strfmt "github.com/go-openapi/strfmt"
)

// NewPostRemoteAPIJAccountFetchEmailIDParams creates a new PostRemoteAPIJAccountFetchEmailIDParams object
// with the default values initialized.
func NewPostRemoteAPIJAccountFetchEmailIDParams() *PostRemoteAPIJAccountFetchEmailIDParams {
	var ()
	return &PostRemoteAPIJAccountFetchEmailIDParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewPostRemoteAPIJAccountFetchEmailIDParamsWithTimeout creates a new PostRemoteAPIJAccountFetchEmailIDParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewPostRemoteAPIJAccountFetchEmailIDParamsWithTimeout(timeout time.Duration) *PostRemoteAPIJAccountFetchEmailIDParams {
	var ()
	return &PostRemoteAPIJAccountFetchEmailIDParams{

		timeout: timeout,
	}
}

// NewPostRemoteAPIJAccountFetchEmailIDParamsWithContext creates a new PostRemoteAPIJAccountFetchEmailIDParams object
// with the default values initialized, and the ability to set a context for a request
func NewPostRemoteAPIJAccountFetchEmailIDParamsWithContext(ctx context.Context) *PostRemoteAPIJAccountFetchEmailIDParams {
	var ()
	return &PostRemoteAPIJAccountFetchEmailIDParams{

		Context: ctx,
	}
}

/*PostRemoteAPIJAccountFetchEmailIDParams contains all the parameters to send to the API endpoint
for the post remote API j account fetch email ID operation typically these are written to a http.Request
*/
type PostRemoteAPIJAccountFetchEmailIDParams struct {

	/*ID
	  Mongo ID of target instance

	*/
	ID string

	timeout time.Duration
	Context context.Context
}

// WithTimeout adds the timeout to the post remote API j account fetch email ID params
func (o *PostRemoteAPIJAccountFetchEmailIDParams) WithTimeout(timeout time.Duration) *PostRemoteAPIJAccountFetchEmailIDParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the post remote API j account fetch email ID params
func (o *PostRemoteAPIJAccountFetchEmailIDParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the post remote API j account fetch email ID params
func (o *PostRemoteAPIJAccountFetchEmailIDParams) WithContext(ctx context.Context) *PostRemoteAPIJAccountFetchEmailIDParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the post remote API j account fetch email ID params
func (o *PostRemoteAPIJAccountFetchEmailIDParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithID adds the id to the post remote API j account fetch email ID params
func (o *PostRemoteAPIJAccountFetchEmailIDParams) WithID(id string) *PostRemoteAPIJAccountFetchEmailIDParams {
	o.SetID(id)
	return o
}

// SetID adds the id to the post remote API j account fetch email ID params
func (o *PostRemoteAPIJAccountFetchEmailIDParams) SetID(id string) {
	o.ID = id
}

// WriteToRequest writes these params to a swagger request
func (o *PostRemoteAPIJAccountFetchEmailIDParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

	r.SetTimeout(o.timeout)
	var res []error

	// path param id
	if err := r.SetPathParam("id", o.ID); err != nil {
		return err
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}